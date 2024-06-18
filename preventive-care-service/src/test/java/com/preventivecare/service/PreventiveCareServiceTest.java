package com.preventivecare.service;

import com.preventivecare.model.Patient;
import com.preventivecare.model.Doctor;
import com.preventivecare.model.MedicalRecord;
import com.preventivecare.model.Hospital;
import com.preventivecare.model.Diagnosis;
import com.preventivecare.repository.CareEntryRepository;
import com.preventivecare.service.PreventiveCareService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class PreventiveCareServiceTest {

    @Mock
    private CareEntryRepository careEntryRepository;

    @InjectMocks
    private PreventiveCareService preventiveCareService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testGetAllPatients() {
        List<Patient> patients = new ArrayList<>();
        patients.add(new Patient("John Doe", "john@example.com"));
        patients.add(new Patient("Jane Smith", "jane@example.com"));

        when(careEntryRepository.findAllPatients()).thenReturn(patients);

        List<Patient> result = preventiveCareService.getAllPatients();

        assertEquals(2, result.size());
        assertEquals("John Doe", result.get(0).getName());
        assertEquals("john@example.com", result.get(0).getEmail());
        assertEquals("Jane Smith", result.get(1).getName());
        assertEquals("jane@example.com", result.get(1).getEmail());

        verify(careEntryRepository, times(1)).findAllPatients();
        verifyNoMoreInteractions(careEntryRepository);
    }

    // Add more test methods for other service methods

}