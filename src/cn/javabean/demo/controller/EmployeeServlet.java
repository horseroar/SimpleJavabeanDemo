package cn.javabean.demo.controller;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.omg.CORBA.Request;

import com.sun.org.apache.bcel.internal.generic.I2F;
import com.sun.org.apache.xpath.internal.operations.And;

import cn.javabean.demo.model.Employee;
import cn.javabean.demo.util.JdbcUtil;
import cn.javabean.demo.util.WebUtil;
import cn.javabean.demo.util.JdbcUtil.PageInfo;

/**
 * 采用jsp+servlet的方式主要是将所有的数据都放在request.attribute里面，然后将请求 <br>
 * 转发至指定的JSP上，由JSP将数据取出，使用JSTL显示在页面中
 * 
 * @author Administrator
 * 
 */
public class EmployeeServlet extends HttpServlet {

	private static final String KEY_URL = "url";
	private static final String KEY_MSG = "msg";
	private static final String COMMON_MSG_PAGE = "/common/showmsg.jsp";
	private static final String EMPLOYEE_EDIT_PAGE = "/employeeMgr/edit.jsp";
	private static final String EMPLOYEE_DEL_PAGE = "/employeeMgr/del.jsp";
	private static final String EMPLOYEE_LIST_SERVLET = "/servlet/EmployeeServlet?action=list";
	private static final String EMPLOYEE_LIST_PAGE = "/employeeMgr/list.jsp";
	private static final String EMPLOYEE_ADD_PAGE = "/employeeMgr/add.jsp";
	private static final String INDEX_PAGE = "/index.jsp";

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		/**
		 * 这里有改进的余地，可以使用java的反射机制，将请求的动作与调用的方法关联起来，<br>
		 * 直接使用反射调用具体的方法，从而避免大量的if else ，为了更高的通用性，此类代码<br>
		 * 一般放置在一个父类Servlet中 <br>
		 * 
		 * 也是为了避免这种不必要的工作，struts框架中可以配置这种url地址到方法的映射，也是<br>
		 * 基于java本身的反射机制来实现的
		 */
		if (action != null) {
			if (action.equals("list")) {
				listEmployee(request, response);
			} else if (action.equals("insert")) {
				insertEmployee(request, response);
			} else if (action.equals("update")) {
				updateEmployee(request, response);
			} else if (action.equals("delete")) {
				deleteEmpoyee(request, response);
			} else if (action.equals("preEdit")) {
				preEditEmployee(request, response);
			} else if (action.equals("preAdd")) {
				preAddEmployee(request, response);
			} else if (action.equals("batchDel")) {
				batchDeleteEmployee(request, response);
			}
		}
	}

	/**
	 * 对选中的员工进行批量删除
	 * 
	 * @param request
	 * @param response
	 */
	private void batchDeleteEmployee(HttpServletRequest request, HttpServletResponse response) {
		// 对id sql字符串进行组装
		String[] values = request.getParameterValues("checkEmp");
		StringBuffer ids = new StringBuffer();
		for (String str : values) {
			ids.append("'").append(str).append("',");
		}
		// 对这些数值进行批量删除
		String sqlBatchDel = MessageFormat.format("delete from employee where empCode in ({0})", ids.toString()
				.replaceAll(",$", ""));// 将尾端的,替换后组装
		JdbcUtil.executeUpdate(sqlBatchDel, null);
		request.setAttribute(KEY_MSG, "删除数据成功!");
		request.setAttribute(KEY_URL, EMPLOYEE_LIST_SERVLET);
		forward(request, response, COMMON_MSG_PAGE);
	}

	/**
	 * 预增加员工(为新增页面准备一些数据)
	 * 
	 * @param request
	 * @param response
	 */
	private void preAddEmployee(HttpServletRequest request, HttpServletResponse response) {
		// 准备部门信息，此处应该从数据库中提取，这里就直接写死了
		List<String> departList = new ArrayList<String>();
		for (int i = 0; i < 10; i++) {
			departList.add("研发科" + (i + 1));
		}
		// 数据放入request域名
		request.setAttribute("departList", departList);
		forward(request, response, EMPLOYEE_ADD_PAGE);
	}

	/**
	 * 预编辑员工（为编辑员工页面准备一些数据）
	 * 
	 * @param request
	 * @param response
	 */
	private void preEditEmployee(HttpServletRequest request, HttpServletResponse response) {
		List<String> departList = new ArrayList<String>();
		for (int i = 0; i < 10; i++) {
			departList.add("研发科" + (i + 1));
		}
		// 取出要编辑的有员工编码
		String empCode = request.getParameter("empCode");
		if (empCode == null || empCode.trim().equals("")) {
			return;
		}
		// 根据员工编码将员工的信息取出
		String sqlText = "select * from employee where empCode=?";
		Employee employee = JdbcUtil.executeQuerySingle(sqlText, Employee.class, empCode);
		// 将员工信息放入request域中,在jsp页面中用JSTL取出作展示
		request.setAttribute("departList", departList);
		request.setAttribute("employee", employee);
		forward(request, response, EMPLOYEE_EDIT_PAGE);
	}

	private void deleteEmpoyee(HttpServletRequest request, HttpServletResponse response) {
		// 取出要编辑的有员工编码
		String empCode = request.getParameter("empCode");
		if (empCode == null || empCode.trim().equals("")) {
			return;
		}
		// 根据传入的empCode对员工表的该记录进行删除
		String sqlText = "delete from employee where empCode=?";
		int result = JdbcUtil.executeUpdate(sqlText, empCode);
		// 根据返回的结果，组装要返回页面的提示信息(页面的信息提示共用common下的showmsg.jsp)
		// 此处要设置消息提示，和返回的url,若不设置返回的url,则使用window.history.go(-1）来进行返回上一页
		String url = "";
		String msg = "";
		if (result > 0) {
			msg = "删除记录成功！";
			url = EMPLOYEE_LIST_SERVLET;
		} else {
			msg = "已经执行删除操作，可能未曾影响到具体记录!";
		}
		request.setAttribute(KEY_MSG, msg);
		request.setAttribute(KEY_URL, url);
		forward(request, response, COMMON_MSG_PAGE);
	}

	/**
	 * 将转发作为一个公共方法进行提取出来
	 * 
	 * @param request
	 * @param response
	 * @param url
	 */
	private void forward(HttpServletRequest request, HttpServletResponse response, String url) {
		try {
			request.getRequestDispatcher(url).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新员工信息
	 * 
	 * @param request
	 * @param response
	 */
	private void updateEmployee(HttpServletRequest request, HttpServletResponse response) {
		// 用类似javabean标签直接注入实体类的方式将request域中的值注入到javabean中
		Employee employee = WebUtil.request2Bean(request, Employee.class);
		String sqlText = "update employee set cardNo=?,departMent=?,name=?,sex=? where empCode=?";
		int result = JdbcUtil.executeUpdate(sqlText, employee.getCardNo(), employee.getDepartMent(),
				employee.getName(), employee.getSex(), employee.getEmpCode());
		if (result > 0) {
			request.setAttribute(KEY_MSG, "更新员工信息成功!");
			request.setAttribute(KEY_URL, EMPLOYEE_LIST_SERVLET);
		} else {
			request.setAttribute(KEY_MSG, "未更新到具体条目或更新失败!");
			// 不设置返回的url,让其跳回上一页
		}
		forward(request, response, COMMON_MSG_PAGE);
	}

	/**
	 * 员工信息入库
	 * 
	 * @param request
	 * @param response
	 */
	private void insertEmployee(HttpServletRequest request, HttpServletResponse response) {
		// 将请求参数中的值注入javabean
		Employee emp = WebUtil.request2Bean(request, Employee.class);
		String sqlText = "insert into employee(cardNo,departMent,empCode,name,sex) values(?,?,?,?,?)";
		int result = JdbcUtil.executeUpdate(sqlText, emp.getCardNo(), emp.getDepartMent(), emp.getEmpCode(), emp
				.getName(), emp.getSex());
		if (result > 0) {
			request.setAttribute(KEY_MSG, "新增员工信息成功!");
			request.setAttribute(KEY_URL, INDEX_PAGE);
		} else {
			request.setAttribute(KEY_MSG, "新增员工信息失败!");
			// 不设置url，让页面跳回上一页
		}
		forward(request, response, COMMON_MSG_PAGE);
	}

	/**
	 * 列出员工的信息列表
	 * 
	 * @param request
	 * @param response
	 */
	private void listEmployee(HttpServletRequest request, HttpServletResponse response) {
		// 获取请求的第几页
		String page = request.getParameter("page");
		Integer currentPage = 1;
		if (page != null && page.matches("^\\d+$")) {
			currentPage = Integer.valueOf(page);
		} else {
			// 尝试从session中检查是否缓存了当前用户观看了哪一页,用于定位之前所在的当前模块的第几页
			Object sessionPage = request.getSession().getAttribute("employee.currentPage");
			if (sessionPage != null && sessionPage instanceof Integer) {
				currentPage = (Integer) sessionPage;
			}
		}
		/*
		 * 在session里记录当前模块的所在页，用于当前连接的用户返回时还返回list的该页
		 */
		request.getSession().setAttribute("employee.currentPage", currentPage);
		// 根据当前页提取员工记录
		String sql = "select * from employee";
		// 提前当前记录总数
		int empCount = JdbcUtil.getRecordCount("select count(*) from employee", null);
		PageInfo pageInfo = new JdbcUtil.PageInfo(currentPage, empCount);
		List<Employee> empList = JdbcUtil.executeQueryPagely(sql, Employee.class, pageInfo, null);
		// 列表和页面数据均设置至request,用于做页面展示
		request.setAttribute("empList", empList);
		request.setAttribute("pageInfo", pageInfo);
		// 请求转发至展示列表
		forward(request, response, EMPLOYEE_LIST_PAGE);
	}

}
