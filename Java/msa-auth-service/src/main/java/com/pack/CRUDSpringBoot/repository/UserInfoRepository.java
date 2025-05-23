package com.pack.CRUDSpringBoot.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.pack.CRUDSpringBoot.entity.UserInfo;

public interface UserInfoRepository extends JpaRepository<UserInfo, Integer>{
     Optional<UserInfo> findByName(String username);
}
