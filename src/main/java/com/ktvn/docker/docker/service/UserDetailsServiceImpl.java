package com.ktvn.docker.docker.service;

import com.ktvn.docker.docker.dao.RoleDAO;
import com.ktvn.docker.docker.dao.UserDAO;
import com.ktvn.docker.docker.entities.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private com.ktvn.docker.docker.dao.UserDAO UserDAO;

    @Autowired
    private com.ktvn.docker.docker.dao.RoleDAO RoleDAO;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        UserEntity userEntity = this.UserDAO.findUserAccount(userName);

        if (userEntity == null) {
            System.out.println("User not found! " + userName);
            throw new UsernameNotFoundException("User " + userName + " was not found in the database");
        }
        System.out.println("Found User: " + userEntity );
        // [ROLE_USER, ROLE_ADMIN,..]
        List<String> roleNames = this.RoleDAO.getRoleNames(userEntity.getUserId());

        List<GrantedAuthority> grantList = new ArrayList<GrantedAuthority>();
        if (roleNames != null) {
            for (String role : roleNames) {
                // ROLE_USER, ROLE_ADMIN,..
                GrantedAuthority authority = new SimpleGrantedAuthority(role);
                grantList.add(authority);
            }
        }
        UserDetails userDetails = (UserDetails) new User(userEntity.getUserName(), //
                userEntity.getEncrytedPassword(), grantList);
        return userDetails;
    }

}
