package com.pack.CRUDSpringBoot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pack.CRUDSpringBoot.entity.Movie;
import com.pack.CRUDSpringBoot.entity.UserInfo;
import com.pack.CRUDSpringBoot.exception.MovieAlreadyExistsException;
import com.pack.CRUDSpringBoot.exception.MovieNotFoundException;
import com.pack.CRUDSpringBoot.repository.MovieRepository;
import com.pack.CRUDSpringBoot.repository.UserInfoRepository;

@Service
public class MovieService {
	
	@Autowired
	MovieRepository movieRepo;

	public Movie createMovie(Movie movie) {
		if(movieRepo.existsById(movie.getId())) {
			throw new MovieAlreadyExistsException("Movie already exists!!!");
		}
		return movieRepo.save(movie);
	}

	public List<Movie> getAllMovies() {
		return movieRepo.findAll();
	}

	public Movie getMovieById(Integer movieId) {
		return movieRepo.findById(movieId).orElseThrow(()->new MovieNotFoundException("Not found movie with id = "+movieId));
	}
	
	@Autowired
	UserInfoRepository userRepo;

	@Autowired
	PasswordEncoder passwordEncoder;
	
	public String addUser(UserInfo userInfo) {
		userInfo.setPassword(passwordEncoder.encode(userInfo.getPassword()));
		userRepo.save(userInfo);
		return "User added successfully into database";
	}
}
