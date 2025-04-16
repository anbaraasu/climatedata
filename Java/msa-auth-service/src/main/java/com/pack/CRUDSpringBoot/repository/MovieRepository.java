package com.pack.CRUDSpringBoot.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pack.CRUDSpringBoot.entity.Movie;

public interface MovieRepository extends JpaRepository<Movie, Integer>{

}
