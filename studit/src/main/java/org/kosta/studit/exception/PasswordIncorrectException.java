package org.kosta.studit.exception;

public class PasswordIncorrectException extends Exception{

	private static final long serialVersionUID = -5537294841272289740L;
	
	public PasswordIncorrectException(String message) {
		super(message);
	}
}
