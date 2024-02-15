import matplotlib.pyplot as plt
import numpy as np
import mpld3
from flask import Flask, render_template

app = Flask(__name__)

# Create some data for the plots
x = np.linspace(0, 2 * np.pi, 100)
y1 = np.sin(x)
y2 = np.cos(x)

# Initialize plot visibility flag
plot1_visible = True
plot2_visible = True

@app.route("/")
def index():
    global y1  # Make y1 a global variable

    # Create the Matplotlib plots
    fig, ax1 = plt.subplots()
    ax1.plot(x, y1, label="Sine Wave")
    ax1.set_title("Plots with Toggle and Update")

    fig, ax2 = plt.subplots()
    ax2.plot(x, y2, label="Cosine Wave")

    # Convert the Matplotlib plots to interactive HTML representations using mpld3
    html_plot1 = mpld3.fig_to_html(fig)
    html_plot2 = mpld3.fig_to_html(fig)

    return render_template("sidebyside.html", html_plot1=html_plot1, html_plot2=html_plot2)

@app.route("/update_plot1")
def update_plot1():
    global y1  # Access the global y1 variable
    y1 = 2 * np.sin(x)  # Update y1 with 2*np.sin(x)
    return "Plot 1 updated."

if __name__ == "__main__":
    # Run the Flask application on port 5005
    app.run(port=5006)