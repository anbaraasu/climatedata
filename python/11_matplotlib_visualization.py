import matplotlib.pyplot as plt
import numpy as np

# Data
x = np.linspace(0, 10, 100)
y = np.sin(x)

# Plot
plt.figure(figsize=(10, 6))
plt.plot(x, y, label='Sine Wave')
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Sine Wave Plot')
plt.legend()
plt.grid(True)
plt.show()
