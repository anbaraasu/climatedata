package com.pack.CRUDSpringBoot;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pack.CRUDSpringBoot.controller.MovieController;
import com.pack.CRUDSpringBoot.entity.Movie;
import com.pack.CRUDSpringBoot.entity.UserInfo;
import com.pack.CRUDSpringBoot.security.JwtAuthFilter;
import com.pack.CRUDSpringBoot.security.JwtService;
import com.pack.CRUDSpringBoot.service.MovieService;

@ExtendWith(MockitoExtension.class)
@WebMvcTest(value=MovieController.class)
@AutoConfigureMockMvc(addFilters=false) //ignore security at time of testing
public class TestMovieController {

	@Autowired
	MockMvc mockMvc;  //explicitly start the server 
	
	@MockBean
	MovieService movieService; //mocking the service
	
	@MockBean
	JwtService jwtService;
	
	@MockBean
	AuthenticationManager authenticationManager;
	
	@MockBean
	JwtAuthFilter jwtFiler;
	
	@Autowired
	ObjectMapper mapper; //read and write json in String
	
	@Test
	public void testCreateMovie() throws Exception {
		//Movie movie=new Movie(100,"Friends","English","Comedy",5);
		Movie movie=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
		
		//when(movieService.createMovie(movie)).thenReturn(movie);
		when(movieService.createMovie(any(Movie.class))).thenReturn(movie);
		
		ResultActions response = mockMvc.perform(post("/api/movie")
				.contentType(MediaType.APPLICATION_JSON)
				.content(mapper.writeValueAsString(movie)));
		
		response.andDo(print())
		        .andExpect(status().isCreated())
		        .andExpect(jsonPath("$.name",is(movie.getName())))
		        .andExpect(jsonPath("$.language",is(movie.getLanguage())));
	}
	
	@Test
	public void testGetAllMovies() throws Exception {
		Movie movie1=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
		Movie movie2=Movie.builder().id(101).name("Room").language("English").type("Horror").rating(4).build();
		
		List<Movie> list=new ArrayList<>();
		list.add(movie1);
		list.add(movie2);
		
		when(movieService.getAllMovies()).thenReturn(list);
		//doReturn(list).when(movieService.getAllMovies());
		
		ResultActions response=mockMvc.perform(get("/api/movie"));
		MockHttpServletResponse res=response.andReturn().getResponse();
		Movie[] movie=mapper.readValue(res.getContentAsString(), Movie[].class);
		
		assertEquals(movie[0].getName(),movie1.getName());
		assertEquals(movie[1].getType(),movie2.getType());
	}
	
	@Test
	public void testGetMovieById() throws Exception {
		Movie movie1=Movie.builder().id(100).name("Friends").language("English").type("Comedy").rating(5).build();
		
		//when(movieService.getMovieById(movie1.getId())).thenReturn(movie1);
		when(movieService.getMovieById(anyInt())).thenReturn(movie1);
		
		ResultActions response=mockMvc.perform(get("/api/movie/{mId}",100));
		MockHttpServletResponse res=response.andReturn().getResponse();
		Movie movie=mapper.readValue(res.getContentAsString(), Movie.class);
		
		assertEquals(movie.getName(),movie1.getName());
	}
	
	@Test
	public void testAddUser() throws Exception {
		UserInfo user=new UserInfo(1000,"Ram","ram@gmail.com","abcd","ADMIN");
		
		when(movieService.addUser(any(UserInfo.class))).thenReturn("User added successfully into database");
		
		ResultActions response = mockMvc.perform(post("/api/new")
				.contentType(MediaType.APPLICATION_JSON)
				.content(mapper.writeValueAsString(user)));
		
		response.andDo(print())
		        .andExpect(status().isOk());
		        
	}
}
