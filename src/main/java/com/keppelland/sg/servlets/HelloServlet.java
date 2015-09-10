package com.keppelland.sg.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keppelland.sg.common.Common;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Version;
import com.restfb.exception.FacebookOAuthException;
import com.restfb.types.Page;
import com.restfb.types.User;

/**
 * Servlet implementation class HelloServlet
 */
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final FacebookClient fbClient;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        fbClient = new DefaultFacebookClient(Common.ACCESS_TOKEN, Version.VERSION_2_4);        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("* Fetching single objects *");
		try{
			User user = fbClient.fetchObject("me", User.class);
			Page page = fbClient.fetchObject("tradesbyjack", Page.class);
		    out.println("User name: " + user.getName());
		    out.println("User name: " + user.getId());
		    out.println("User name: " + user.getGender());
		    out.println("Page likes: " + page.getLikes());
		} catch(FacebookOAuthException fbexp){
			out.println("Cannot find user info. " + fbexp.getErrorMessage());
		}
	}
}