package cn.javabean.demo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

/**
 * 封装的粗糙的JDBC工具类
 * 
 * @author Administrator
 * 
 */
public class JdbcUtil {
	/**
	 * 获取一个可用的数据库连接
	 * 
	 * @return
	 * @throws Exception
	 */
	public static Connection getConnection() throws Exception {
		String url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8";
		String user = "root";
		String password = "";
		String driverName = "com.mysql.jdbc.Driver";
		Class.forName(driverName);
		Connection connection = DriverManager.getConnection(url, user, password);
		return connection;
	}

	/**
	 * 关闭数据连接产生的三个对象
	 * 
	 * @param rs
	 * @param pstat
	 * @param conn
	 */
	public static void close(ResultSet rs, Statement pstat, Connection conn) {

		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		if (pstat != null)
			try {
				pstat.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		if (conn != null)
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

	}

	/**
	 * 将rs的记录填充到对应的实体类中
	 * 
	 * @param <T>
	 * @param beanClass
	 * @param rs
	 * @return
	 */
	public static <T> T rs2bean(Class<T> beanClass, ResultSet rs) {
		T bean = null;
		try {
			bean = beanClass.newInstance();
			int columnCount = rs.getMetaData().getColumnCount();
			for (int i = 1; i <= columnCount; i++) {
				String columnName = rs.getMetaData().getColumnName(i);
				BeanUtils.setProperty(bean, columnName, rs.getObject(columnName));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	/**
	 * 取得记录条数
	 * 
	 * @param sqlText
	 * @param params
	 * @return
	 */
	public static int getRecordCount(String sqlText, Object... params) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstat = null;
		ResultSet rs = null;
		try {
			conn = JdbcUtil.getConnection();
			pstat = conn.prepareStatement(sqlText);
			// 设置参数
			if (params != null)
				for (int i = 0; i < params.length; i++) {
					pstat.setObject((i + 1), params[i]);
				}
			rs = pstat.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstat, conn);
		}
		return count;
	}

	/**
	 * 执行更新操作
	 * 
	 * @param sqlText
	 * @param params
	 */
	public static int executeUpdate(String sqlText, Object... params) {
		Connection conn = null;
		PreparedStatement pstat = null;
		try {
			conn = JdbcUtil.getConnection();
			pstat = conn.prepareStatement(sqlText);
			// 设置参数
			if (params != null)
				for (int i = 0; i < params.length; i++) {
					pstat.setObject((i + 1), params[i]);
				}
			return pstat.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(null, pstat, conn);
		}
		return -1;
	}

	public static <T> List<T> executeQueryPagely(String sqlText, Class<T> beanClass, PageInfo pi, Object... params) {
		// 将sql语句处理一下，添加limit连接串
		if (sqlText.indexOf("limit") != -1) {
			throw new RuntimeException("传入的sql语句中不能含有limit关键字!因为底层方法已经有连接limit的连接操作！");
		}
		sqlText = sqlText.trim();
		sqlText = sqlText + " limit " + pi.getRecordStartIndex() + "," + pi.getRecordSizePerPage();
		return executeQuery(sqlText, beanClass, params);
	}

	/**
	 * 得到唯一的单条记录
	 * 
	 * @param <T>
	 * @param sqlText
	 * @param beanClass
	 * @param pi
	 * @param params
	 * @return
	 */
	public static <T> T executeQuerySingle(String sqlText, Class<T> beanClass, Object... params) {
		PageInfo pi = new PageInfo(1, 1);
		List<T> lists = executeQueryPagely(sqlText, beanClass, pi, params);
		if (lists != null && lists.size() > 0) {
			return lists.get(0);
		}
		return null;
	}

	/**
	 * 进行查询操作,将结果集封装到对象列表中
	 * 
	 * @param sqlText
	 * @param params
	 * @return
	 */
	public static <T> List<T> executeQuery(String sqlText, Class<T> beanClass, Object... params) {
		List<T> list = new ArrayList<T>();
		Connection conn = null;
		PreparedStatement pstat = null;
		ResultSet rs = null;
		try {
			conn = JdbcUtil.getConnection();
			pstat = conn.prepareStatement(sqlText);
			// 设置参数
			if (params != null)
				for (int i = 0; i < params.length; i++) {
					pstat.setObject((i + 1), params[i]);
				}
			rs = pstat.executeQuery();
			while (rs.next()) {
				T t = rs2bean(beanClass, rs);
				list.add(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstat, conn);
		}
		return list;
	}

	public static List<String> executeQuery(String sqlText, Object... params) {
		List<String> lists = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement pstat = null;
		ResultSet rs = null;
		try {
			conn = JdbcUtil.getConnection();
			pstat = conn.prepareStatement(sqlText);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					pstat.setObject((i + 1), params[i]);
				}
			}
			rs = pstat.executeQuery();
			while (rs.next()) {
				lists.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstat, conn);
		}
		return lists;
	}

	public static class PageInfo {

		public static final int RECORD_SIZE_PERPAGE = 10; // 默认每页记录数
		private int pageCount; // 总页数
		private int currentPage; // 当前页
		private int recordCount; // 记录总数
		private int recordSizePerPage;// 每页显示的记录数
		private int recordStartIndex;// 记录的起始号

		/**
		 * 当前页，记录总数
		 * 
		 * @param currentPage
		 * @param recordCount
		 */
		public PageInfo(int currentPage, int recordCount) {
			this.currentPage = currentPage;
			this.recordCount = recordCount;
			this.recordSizePerPage = RECORD_SIZE_PERPAGE;
			calcOtherInfoOfPage();
		}

		/**
		 * 当前页 记录数 每页大小
		 * 
		 * @param currentPage
		 * @param recordCount
		 * @param recrodSizePerPage
		 */
		public PageInfo(int currentPage, int recordCount, int recrodSizePerPage) {
			this.currentPage = currentPage;
			this.recordCount = recordCount;
			this.recordSizePerPage = recrodSizePerPage;
			calcOtherInfoOfPage();
		}

		/**
		 * 若私自设置了pageinfo的属性，请调用这个方法重新计算信息
		 */
		public void calcOtherInfoOfPage() {
			// 计算总页数
			int pageCount;
			// 判断如果是0，则页数据直接为1
			if (this.getRecordCount() == 0) {
				pageCount = 1;
			} else {
				pageCount = this.getRecordCount() / this.getRecordSizePerPage();
				if (this.getRecordCount() % this.getRecordSizePerPage() > 0) {
					pageCount++;
				}
			}
			this.setPageCount(pageCount);
			// 对当前页进行校正，如果超出范围，将其调整到范围的边缘
			if (this.getCurrentPage() <= 0) {
				this.setCurrentPage(1); // 低于页面下限，调整至最低下限
			}
			if (this.getCurrentPage() > this.getPageCount()) {
				this.setCurrentPage(this.getPageCount()); // 将超出的页调整到最大页面
			}
			recalcRecordStartIndex();
		}

		/**
		 * 计算记录的起始号
		 * 
		 * @return
		 */
		private void recalcRecordStartIndex() {
			int recordStartIndex = (this.getCurrentPage() - 1) * this.getRecordSizePerPage();
			this.setRecordStartIndex(recordStartIndex);
		}

		// getters and setters
		public int getPageCount() {
			return pageCount;
		}

		public void setPageCount(int pageCount) {
			this.pageCount = pageCount;
		}

		public int getCurrentPage() {
			return currentPage;
		}

		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}

		public int getRecordCount() {
			return recordCount;
		}

		public void setRecordCount(int recordCount) {
			this.recordCount = recordCount;
		}

		public int getRecordSizePerPage() {
			return recordSizePerPage;
		}

		public void setRecordSizePerPage(int recordSizePerPage) {
			this.recordSizePerPage = recordSizePerPage;
		}

		public int getRecordStartIndex() {
			return recordStartIndex;
		}

		public void setRecordStartIndex(int recordStartIndex) {
			this.recordStartIndex = recordStartIndex;
		}
	}
}
