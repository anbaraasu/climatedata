package com.pack.CRUDSpringBoot;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.pack.CRUDSpringBoot.entity.UserInfo;
import com.pack.CRUDSpringBoot.repository.UserInfoRepository;
import com.pack.CRUDSpringBoot.service.UserInfoUserDetailsService;

@ExtendWith(MockitoExtension.class)
@SpringBootTest
public class TestUserInfoUserDetailsService {

	@MockBean
	UserInfoRepository userRepo;
	
	@InjectMocks
	UserInfoUserDetailsService userService;
	
	/*UserInfo userInfo;
	
	@BeforeEach
	public void setUp() {
		userInfo=new UserInfo();
		userInfo.setName("Test");
		userInfo.setEmail("test@gmail.com");
		userInfo.setPassword("abcd");
		userInfo.setRole("ROLE_USER");
	}*/
	
	@Test
	public void testLoadUserByUsername_UserExists_ReturnUserDetails() {
		UserInfo userInfo=new UserInfo();
		userInfo.setName("Test");
		userInfo.setEmail("test@gmail.com");
		userInfo.setPassword("abcd");
		userInfo.setRole("ROLE_USER");
		
		when(userRepo.findByName(anyString())).thenReturn(Optional.of(userInfo));
		
		UserDetails userDetails=userService.loadUserByUsername(userInfo.getName());
		
		assertNotNull(userDetails);
		
		assertEquals("Test",userDetails.getUsername());
		assertEquals("abcd",userDetails.getPassword());
		assertEquals(1,userDetails.getAuthorities().size());
	}
	
	@Test
	public void testLoadUserByUsername_UserDoesNotExist() {
		when(userRepo.findByName(anyString())).thenReturn(Optional.empty());
		
		UsernameNotFoundException exception=assertThrows(UsernameNotFoundException.class,() -> userService.loadUserByUsername("test"));
		
		assertEquals("User not found test",exception.getMessage());
	}
}
