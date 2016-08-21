package cn.javabean.demo.model;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

import cn.javabean.demo.util.JdbcUtil;
import cn.javabean.demo.util.JdbcUtil.PageInfo;

public class User {
	private int id;
	private String username;
	private String password;

	/**
	 * 登录
	 * 
	 * @return
	 */
	public boolean login() {
		if (this.getUsername() != null && this.getUsername() != null) {
			String sql = "select count(*) from user where username=? and password=?";
			int recordCount = JdbcUtil.getRecordCount(sql, this.getUsername(), this.getPassword());
			if (recordCount > 0) {
				return true;
			}
		} else {
			throw new RuntimeException("未设置用户名密码或传入的用户名和密码不能为空值!");
		}
		return false;
	}

	/**
	 * 显示用户信息
	 * 
	 * @param currentPage
	 * @return
	 */
	public Map findAll(int currentPage) {
		Map resultMap = new HashMap();
		// 组装分页对象
		String sqlCount = "select count(*) from user";
		int recordCount = JdbcUtil.getRecordCount(sqlCount, null);
		PageInfo pageInfo = new JdbcUtil.PageInfo(currentPage, recordCount);
		// 组装sql语句
		String sqlText = "select * from user";
		List<User> userList = JdbcUtil.executeQueryPagely(sqlText, User.class, pageInfo, null);
		resultMap.put("userList", userList);
		resultMap.put("pageInfo", pageInfo);
		return resultMap;
	}

	/**
	 * 按ID对用户进行删除
	 * 
	 * @param id
	 * @return
	 */
	public int delete(int id) {
		String sqlText = "delete from user where id=?";
		int result = JdbcUtil.executeUpdate(sqlText, id);
		return result;
	}

	/**
	 * 增加用户信息
	 * 
	 * @param id
	 * @return
	 */
	public String insert() {
		String sqlCount = "select count(*) from user where username=?";
		int recordCount = JdbcUtil.getRecordCount(sqlCount, this.getUsername());
		if (recordCount > 0) {
			return "存在相同用户名的用户，不能重复添加!";
		}
		String sqlText = "insert into user(username,password) values(?,?)";
		int result = JdbcUtil.executeUpdate(sqlText, this.getUsername(), this.getPassword());
		if (result > 0) {
			return "添加用户成功!";
		} else {
			return "添加用户失败!";
		}
	}

	/**
	 * 更新用户信息,返回消息
	 * 
	 * @return
	 */
	public String update() {
		// 检查是否有重名的用户
		String sqlCount = "select count(*) from user where username=? and id!=?";
		int recordCount = JdbcUtil.getRecordCount(sqlCount, this.getUsername(), this.getId());
		if (recordCount > 0) {
			return "存在同名的用户，无法进行更新";
		}
		// 执行更新
		String sqlText = "update user set username=?,password=? where id=?";
		int result = JdbcUtil.executeUpdate(sqlText, this.getUsername(), this.getPassword(), this.getId());
		if (result > 0) {
			return "更新成功";
		} else {
			return "记录未更新或更新失败";
		}
	}

	/**
	 * 根据ID将用户名和密码填充到javabean中
	 */
	public void findUserById() {
		String sql = "select * from user where id=?";
		User user = JdbcUtil.executeQuerySingle(sql, User.class, this.getId());
		// 将提取出的user类的属性拷贝至当前对象中
		try {
			BeanUtils.copyProperties(this, user);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
