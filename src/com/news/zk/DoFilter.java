package com.news.zk;

import java.io.IOException;

import javax.servlet.*;


public class DoFilter implements Filter
{

public void destroy() {
}

public void doFilter(ServletRequest arg0, ServletResponse arg1,
FilterChain arg2) throws IOException, ServletException {

arg1.setCharacterEncoding("UTF-8");//和页面数据库的编码要保持一致.
arg2.doFilter(arg0, arg1);

}

public void init(FilterConfig arg0) throws ServletException {
}

}
