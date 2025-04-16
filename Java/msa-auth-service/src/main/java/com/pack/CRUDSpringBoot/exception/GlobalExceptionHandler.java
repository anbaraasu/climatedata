package com.pack.CRUDSpringBoot.exception;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	/*@ExceptionHandler(value=MovieAlreadyExistsException.class)
	@ResponseStatus(HttpStatus.CONFLICT)
	public @ResponseBody ErrorResponse handleMovieAlreadyExists(MovieAlreadyExistsException e) {
		return new ErrorResponse(HttpStatus.CONFLICT.value(),e.getMessage());
	}
	
	@ExceptionHandler(value=MovieNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public @ResponseBody ErrorResponse handleMovieNotFound(MovieNotFoundException e) {
		return new ErrorResponse(HttpStatus.NOT_FOUND.value(),e.getMessage());
	}*/
	
	@ExceptionHandler(value=MovieAlreadyExistsException.class)
	@ResponseStatus(HttpStatus.CONFLICT)
	public ProblemDetail handleMovieAlreadyExists(MovieAlreadyExistsException e) throws Exception {
		ProblemDetail p=ProblemDetail.forStatusAndDetail(HttpStatus.CONFLICT, e.getMessage());
        p.setProperty("host", "localhost");
        p.setProperty("port", 5000);
        p.setType(new URI("http://localhost:5000/movie/movie-not-found"));
        p.setTitle("Movie already exists exception");
        p.setDetail("Movie already exists since we are storing movie with same id");
        p.setStatus(HttpStatus.CONFLICT);
        return p;
	}
	
	@ExceptionHandler(value=MovieNotFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public ProblemDetail handleMovieNotFound(MovieNotFoundException e) throws Exception {
		ProblemDetail p=ProblemDetail.forStatusAndDetail(HttpStatus.NOT_FOUND, e.getMessage());
        p.setProperty("host", "localhost");
        p.setProperty("port", 5000);
        p.setType(new URI("http://localhost:5000/movie/movie-not-found"));
        p.setTitle("Movie not found exception");
        p.setDetail("Movie not found with given id");
        p.setStatus(HttpStatus.NOT_FOUND);
        return p;
	}
	
	@ExceptionHandler(value=MethodArgumentNotValidException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public Map<String,String> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
		Map<String,String> errors=new HashMap<>();
		List<ObjectError> allErrors=e.getBindingResult().getAllErrors();
		allErrors.forEach(err -> {
			FieldError fe=(FieldError)err;
			errors.put(fe.getField(), fe.getDefaultMessage());
		});
		return errors;
	}
}
