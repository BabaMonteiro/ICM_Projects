import qrcode
import os

# API URL remains the same
api_url = "https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple"

# Function to generate QR code for the given URL
def generate_qr_code(url, dir_path):
    qr = qrcode.make(url)
    file_path = os.path.join(dir_path, "api_url_qr.png")
    qr.save(file_path)
    print(f"Saved QR code to {file_path}")

# Directory setup remains the same
directory = os.path.join(os.path.dirname(__file__), "../../images/qrCodes")
if not os.path.exists(directory):
    os.makedirs(directory)

# Call the updated function with the API URL
generate_qr_code(api_url, directory)
