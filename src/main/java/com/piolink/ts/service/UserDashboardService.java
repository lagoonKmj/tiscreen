package com.piolink.ts.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.piolink.ts.domain.UserDashboard;
import com.piolink.ts.repository.UserDashboardRepository;

@Transactional
@Service
public class UserDashboardService {

    @Autowired private UserDashboardRepository repository;
    
    public UserDashboardService() {
    }
    
    public Iterable<UserDashboard> findAll() {
        return repository.findAll();
    }
    
    public UserDashboard findOne(Long id) {
        return repository.findOne(id);
    }
    
    public UserDashboard save(UserDashboard entity) {
        return repository.save(entity);
    }
    
    public void delete(Long id) {
        repository.delete(id);
    }
    
    public Iterable<UserDashboard> findByUserId(Long userId) {
        /*
            conf_user_dashboard 테이블이 com_user 와의 관계가 있어서 DB가 아닌 임시로 소스에 데이터를 작성합니다.
            INSERT INTO `cproject`.`conf_user_dashboard` (`user_id`, `index`, `name`, `is_share`, `description`, `is_use`) VALUES ('-1', '1', '네트워크 모니터링', 'N', '기본대시보드로 제공', 'Y');
            INSERT INTO `cproject`.`conf_user_dashboard` (`user_id`, `index`, `name`, `is_share`, `description`, `is_use`) VALUES ('-1', '2', '보안 모니터링', 'N', '기본대시보드로 제공', 'Y');
            INSERT INTO `cproject`.`conf_user_dashboard` (`user_id`, `index`, `name`, `is_share`, `description`, `is_use`) VALUES ('-1', '3', '트래픽 모니터링', 'N', '기본대시보드로 제공', 'Y');
            INSERT INTO `cproject`.`conf_user_dashboard` (`user_id`, `index`, `name`, `is_share`, `description`, `is_use`) VALUES ('-1', '4', '자산 모니터링', 'N', '기본대시보드로 제공', 'N');
         */
        if (userId == -1) {
            List<UserDashboard> tempList = new ArrayList<UserDashboard>();
            UserDashboard u1 = new UserDashboard();
            u1.setId(1001L);
            u1.setIndex(1);
            u1.setName("네트워크 모니터링");
            tempList.add(u1);
            UserDashboard u2 = new UserDashboard();
            u2.setId(1002L);
            u2.setIndex(2);
            u2.setName("보안 모니터링");
            tempList.add(u2);
            return tempList;
        }
        return repository.findByUserId(userId);
    }
}