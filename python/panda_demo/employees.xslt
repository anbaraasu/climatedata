<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="/Employees">
    <html>
      <body>
        <h2>Employee List</h2>
        <table border="1">
          <tr>
            <th>Employee ID</th>
            <th>Name</th>
            <th>Department</th>
            <th>Salary</th>
          </tr>
          <xsl:for-each select="Employee">
            <tr>
              <td><xsl:value-of select="Employee_ID" /></td>
              <td><xsl:value-of select="Name" /></td>
              <td><xsl:value-of select="Department" /></td>
              <td><xsl:value-of select="Salary" /></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
