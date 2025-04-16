package com.pack.CRUDSpringBoot.exception;

public class MovieNotFoundException extends RuntimeException{

	public MovieNotFoundException(String message) {
		super(message);
	}

	public MovieNotFoundException() {
		super("Movie Not Found");
	}
    
    
}
