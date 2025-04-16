package com.pack.CRUDSpringBoot;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import com.pack.CRUDSpringBoot.entity.Movie;
import com.pack.CRUDSpringBoot.repository.MovieRepository;
import com.pack.CRUDSpringBoot.service.MovieService;

@ExtendWith(MockitoExtension.class)
@SpringBootTest
public class TestMovieService {

	//@Autowired
	@InjectMocks
	MovieService movieService;
	
	@MockBean
	MovieRepository movieRepo;
	
	@Test
	public void testCreateMovie() {
		Movie movie1=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
		
		when(movieRepo.save(any(Movie.class))).thenReturn(movie1);
		
		assertThat(movieService.createMovie(movie1)).isEqualTo(movie1);
	}
	
	@Test
	public void testGetAllMovies() {
		Movie movie1=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
        Movie movie2=Movie.builder().id(101).name("Room").language("English").type("Horror").rating(4).build();
		
		List<Movie> list=new ArrayList<>();
		list.add(movie1);
		list.add(movie2);
		
		when(movieRepo.findAll()).thenReturn(list);
		
		assertThat(movieService.getAllMovies()).isEqualTo(list);
	}
	
	@Test
	public void testGetMovieById() {
		Movie movie1=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
		
		when(movieRepo.findById(anyInt())).thenReturn(Optional.of(movie1));
		
		assertThat(movieService.getMovieById(100)).isEqualTo(movie1);
	}
	
}
