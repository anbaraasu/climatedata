package com.pack.CRUDSpringBoot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pack.CRUDSpringBoot.entity.AuthRequest;
import com.pack.CRUDSpringBoot.entity.Movie;
import com.pack.CRUDSpringBoot.entity.UserInfo;
import com.pack.CRUDSpringBoot.security.JwtService;
import com.pack.CRUDSpringBoot.service.MovieService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/api")
@Tag(name = "Movie API", description = "API for managing movies and user authentication")
public class MovieController {
	
	@Autowired
	MovieService movieService;

	@Operation(summary = "Welcome message", description = "Anyone can access this endpoint")
	@GetMapping("/welcome")
	public ResponseEntity<String> welcome() {
		return new ResponseEntity<>("Movie Application", HttpStatus.OK);
	}
	
	@Operation(summary = "Create a new movie", description = "Only admin can access this endpoint")
	@PostMapping("/movie")
	@PreAuthorize("hasAuthority('ADMIN')")
	public ResponseEntity<Movie> createMovie(@Validated @RequestBody Movie movie) {
		 Movie savedMovie=movieService.createMovie(movie);
		 return new ResponseEntity<Movie>(savedMovie, HttpStatus.CREATED);
	}
	
	@Operation(summary = "Get all movies", description = "Only admin can access this endpoint")
	@GetMapping("/movie")
	@PreAuthorize("hasAuthority('ADMIN')")
	public ResponseEntity<List<Movie>> getAllMovies() {
		try {
			List<Movie> list=movieService.getAllMovies();
			if(list.isEmpty())
				return new ResponseEntity<>(HttpStatus.NO_CONTENT);
			return new ResponseEntity<>(list,HttpStatus.CREATED);
		}catch(Exception e) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@Operation(summary = "Get movie by ID", description = "Only user can access this endpoint")
	@GetMapping("/movie/{mid}")
	@PreAuthorize("hasAuthority('USER')")
	public ResponseEntity<Movie> getMovieById(@PathVariable("mid") Integer movieId){
		Movie movie=movieService.getMovieById(movieId);
		return new ResponseEntity<>(movie,HttpStatus.CREATED);
	}
	
	@Operation(summary = "User registration", description = "Anyone can access this endpoint")
	@PostMapping("/user/registration")
	public String addNewUser(@RequestBody UserInfo userInfo) {
		return movieService.addUser(userInfo);
	}
	
	@Autowired
	JwtService jwtService;
	
	@Autowired
	AuthenticationManager authenticationManager;
	
	@Operation(summary = "User authentication", description = "Anyone can access this endpoint")
	@PostMapping("/user/authenticate")
	public String generateJWTToken(@RequestBody AuthRequest authRequest) {
		Authentication authentication=authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
		if(authentication.isAuthenticated())
		     return jwtService.generateToken(authRequest.getUsername());
		else
			throw new UsernameNotFoundException("Invalid User request");
	}
}
