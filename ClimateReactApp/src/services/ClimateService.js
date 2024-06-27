class ClimateService {
  async fetchClimateData() {
    try {
      const response = await fetch('http://localhost:1111/api/climates');
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('Error fetching climate data:', error);
      throw error;
    }
  }
}

export default ClimateService;