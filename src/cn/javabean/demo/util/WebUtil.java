package cn.javabean.demo.util;

import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.Converter;

/**
 * 工具类 可以与servlet层（控制层）有交集
 * 
 * @author Administrator
 * 
 */
public class WebUtil {

	// 将request里的数据设置到bean中去
	public static Object request2Bean(HttpServletRequest request, Object bean) throws Exception {
		// 只对post 起作用
		// request.setCharacterEncoding("UTF-8");
		// 1.取出request里的所有参数属性及其值
		List<String> attribList = new ArrayList<String>();
		List<String> valueList = new ArrayList<String>();
		for (Enumeration e = request.getParameterNames(); e.hasMoreElements();) {
			String attribName = (String) e.nextElement();
			attribName = new String(attribName.getBytes("ISO8859-1"), "UTF-8");
			attribList.add(attribName);
			valueList.add((request.getParameter(attribName) == null) ? "" : request.getParameter(attribName));
			System.out.println(attribName + ":"
					+ new String(request.getParameter(attribName).getBytes("ISO8859-1s"), "UTF-8"));
		}
		// 2.使用beanutils将属性以及对应的值设置到bean对象中去
		for (int i = 0; i < attribList.size(); i++) {
			BeanUtils.setProperty(bean, attribList.get(i), valueList.get(i));
		}
		return bean;
	}

	// RegisterForm.class 传进来是什么，返回的就是什么
	public static <T> T request2Bean(HttpServletRequest request, Class<T> beanClass) {
		T bean = null;
		try {
			// 1.创建要封装数据的bean
			bean = beanClass.newInstance();
			// 2.把request中的数据整到bean中
			Enumeration e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String name = (String) e.nextElement();
				String value = request.getParameter(name);
				BeanUtils.setProperty(bean, name, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}

	/**
	 * 将字符串的首字母转成大写
	 * 
	 * @param name
	 * @return
	 */
	public static String firstCharToLowerCase(String name) {
		char ch = name.charAt(0);
		String name_1 = name.substring(1);
		if (ch >= 'a' && ch <= 'z') {
			ch -= 32;
		}
		name_1 = ch + name_1;
		return name_1;
	}

	public static void copyProperties(Object srcBean, Object dstBean) {

		// 需要注册一个转换器，由于BeanUtils只支持九种基本类型
		ConvertUtils.register(new Converter() {

			public Object convert(Class type, Object value) {
				if (value == null) {
					return null;
				}
				String str = (String) value;
				if (str.trim().equals("")) {
					return null;
				}

				// 1980-1-1
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					return sdf.parse(str);
				} catch (ParseException e) {
					// 暂停以下的转换，停止整个程序
					throw new RuntimeException(e);
				}
			}

		}, Date.class);

		try {
			BeanUtils.copyProperties(dstBean, srcBean);
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 验证是否为空字符串(not null and not equals "")
	 * 
	 * @param str
	 * @return 若为空字符串，返回真；若不为空字符串，返回假
	 */
	public static boolean isNullString(String str) {
		if (str == null || str.trim().equals("")) {
			return true;
		}
		return false;
	}

}
