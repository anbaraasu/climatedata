package pl.piomin.services.organization.client;
    

import org.springframework.stereotype.Component;
import pl.piomin.services.organization.model.Employee;

import java.util.Collections;
import java.util.List;

@Component
public class EmployeeClientFallback implements EmployeeClient {

	@Override
	public List<Employee> findByOrganization(Long organizationId) {
		return Collections.emptyList();
	}
}


