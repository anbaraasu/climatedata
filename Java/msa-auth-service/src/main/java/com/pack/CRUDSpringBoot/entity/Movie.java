package com.pack.CRUDSpringBoot.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Movie {
	@Id
    private Integer id;
	@NotNull(message="Movie name cannot be null")
    private String name;
	@NotNull(message="Movie language cannot be null")
    private String language;
	@NotNull(message="Movie type cannot be null")
    private String type;
	@Min(value=1,message="Rating minimum value should be 1")
	@Max(value=5,message="Rating maximum value should be 5")
    private Integer rating;
}
