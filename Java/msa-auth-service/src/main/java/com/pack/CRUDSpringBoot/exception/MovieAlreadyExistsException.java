package com.pack.CRUDSpringBoot.exception;

public class MovieAlreadyExistsException extends RuntimeException {

	public MovieAlreadyExistsException(String message) {
		super(message);
	}

	public MovieAlreadyExistsException() {
		super("Movie Already Exists");
	}
}
