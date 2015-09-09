package com.keppelland.sg.models;

import com.restfb.Facebook;

public class FqlUser {
	@Facebook
	String uid;

	@Facebook
	String name;

	@Override
	public String toString() {
		return String.format("%s (%s)", name, uid);
	}
}