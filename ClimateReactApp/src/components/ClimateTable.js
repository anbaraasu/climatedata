import React, { useEffect, useState } from 'react';
import ClimateService from '../services/ClimateService';

const ClimateTable = () => {
  const [climateData, setClimateData] = useState([]);

  useEffect(() => {
    const fetchClimateData = async () => {
      try {
        const data = await ClimateService.getClimateData();
        setClimateData(data);
      } catch (error) {
        console.error('Error fetching climate data:', error);
      }
    };

    fetchClimateData();
  }, []);

  return (
    <div>
      <h2>Climate Data</h2>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Temperature</th>
            <th>Humidity</th>
            <th>Wind Speed</th>
          </tr>
        </thead>
        <tbody>
          {climateData.map((climate) => (
            <tr key={climate.id}>
              <td>{climate.date}</td>
              <td>{climate.temperature}</td>
              <td>{climate.humidity}</td>
              <td>{climate.windSpeed}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default ClimateTable;