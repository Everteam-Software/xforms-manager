/**
 * Copyright (c) 2010 Intalio inc.
 *
 * The program(s) herein may be used and/or copied only with the
 * written permission of Intalio Inc. or in accordance with the terms
 * and conditions stipulated in the agreement/contract under which the
 * program(s) have been supplied.
 *	
 * Contributors:
 * Intalio inc. - initial API and implementation
 * @author atul@intalio.com , Atul Kumar Singh</a>

 */
package org.intalio.tempo.oxf;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * The security filter has been made to check whether the user(Logged in) has access to the task  
 * JIRA WF-1462
 */

public class SecurityFilter implements javax.servlet.Filter {

    public void destroy() {
     }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String token="";
        boolean tokenexistinparameter=false;
        String cookietoken="";
        HttpServletRequest hReq = (HttpServletRequest) request;
        HttpServletResponse hRes=(HttpServletResponse) response;
        StringBuffer loginurl=hReq.getRequestURL(); 
        int i=loginurl.indexOf(hReq.getContextPath());
        if (i!=-1)
        {
        loginurl.delete(i, loginurl.length());
        loginurl.append("/ui-fw"); 
        }
        Enumeration<String> enums = request.getParameterNames();
        while (enums.hasMoreElements()) {
            String paramName = enums.nextElement();
            if("token".equals(paramName))
            {
            	tokenexistinparameter=true;
            	token=request.getParameter(paramName);
            }
        }
        
        if(!tokenexistinparameter)
        {
        	chain.doFilter(request, response);
        	return;
        }
        Cookie[] cookies = hReq.getCookies();
        if (cookies!=null)
        {
        	for (int k = 0; k < cookies.length; k++) {
               	if("singleLogin".equals(cookies[k].getName()))
            	{
            	cookietoken=cookies[k].getValue();
            	}
            }
        }
        if ("".equals(token)||"".equals(cookietoken))
        {
        	hRes.sendRedirect(loginurl.toString());
        	return;
        }
        else if (token.equals(cookietoken))
        {
        	chain.doFilter(request, response);
        	return;
        }
        else
        {
        	hRes.sendRedirect(loginurl.toString());
        	return;
        }
   	}

    public void init(FilterConfig arg0) throws ServletException {
    }

}
