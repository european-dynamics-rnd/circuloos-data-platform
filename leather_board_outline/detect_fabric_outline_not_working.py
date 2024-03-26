import cv2
import numpy as np
from skimage import exposure
from skimage.filters import threshold_otsu
from skimage.morphology import binary_closing, binary_opening
from skimage.measure import find_contours

def detect_fabric_outline(image):
  """
  Detects the fabric outline from a white background image.

  Args:
      image: The input image as a NumPy array.

  Returns:
      A NumPy array with the detected fabric outline.
  """
  # Convert the image to grayscale
  gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

  # Apply thresholding to separate fabric from background
  thresh = cv2.threshold(gray, 200, 255, cv2.THRESH_BINARY_INV)[1]

  # Find contours in the thresholded image
  contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

  # Find the largest contour (assuming the fabric is the largest object)
  largest_contour = max(contours, key=cv2.contourArea)

  # Approximate the contour with a polygon
  approx = cv2.approxPolyDP(largest_contour, 0.01 * cv2.arcLength(largest_contour, True), True)

  # Create a mask filled with black pixels
  mask = np.zeros_like(gray)

  # Draw the approximated contour on the mask
  cv2.drawContours(mask, [approx], -1, (255, 255, 255), -1)

  # Apply bitwise AND operation to get the fabric outline
  outline = cv2.bitwise_and(image, image, mask=mask)

  return outline



def detect_object_outline(image):
  """
  Detects the outline of an object on a white background image using skimage.

  Args:
      image: The input image as a NumPy array.

  Returns:
      A NumPy array with the detected object outline.
  """
  # Enhance contrast (optional, adjust based on image characteristics)
  image_enhanced = exposure.equalize_hist(image)
  image_enhanced = cv2.normalize(image_enhanced, None, alpha=0, beta=1, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_32F)
  # Convert to grayscale
  gray = cv2.cvtColor(image_enhanced, cv2.COLOR_BGR2GRAY)

  # Apply Otsu's thresholding
  thresh = threshold_otsu(gray)
  binary = gray > thresh
  selement = np.ones((3, 3))
  # Morphological operations (optional, adjust based on image noise)
  closed = binary_closing(binary, selement=selement)  # Remove small holes
  opened = binary_opening(closed, selement=selement)  # Remove small protrusions

  # Find contours
  contours = find_contours(opened, connectivity=2)

  # Select largest exterior contour (assuming object is the largest)
  largest_contour = max(contours, key=cv2.contourArea)

  # Create mask from the contour
  mask = np.zeros_like(image[:, :, 0])
  cv2.drawContours(mask, [largest_contour], -1, (255, 255, 255), -1)

  # Apply bitwise AND operation to get the object outline
  outline = cv2.bitwise_and(image, image, mask=mask)

  return outline

# Read the image
image = cv2.imread("./fabric_1_no_ruller_no_aruco.jpg")

# Detect fabric outline
# outline = detect_fabric_outline(image)

outline = detect_object_outline(image)


# Display the original image and the detected outline
cv2.imshow("Original Image", image)
cv2.imshow("Fabric Outline", outline)

# Wait for a key press to close the windows
cv2.waitKey(10000)
cv2.destroyAllWindows()
