# Define the server's domain name
DOMAIN='circuloos-keycloak'

# Generate a private key
openssl genrsa -out "$DOMAIN.key" 2048

# Create a configuration file for the certificate request
cat > "$DOMAIN.cnf" <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = req_ext
x509_extensions = v3_req

[dn]
CN = $DOMAIN

[req_ext]
subjectAltName = @alt_names

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN
EOF

# Generate a CSR with the SAN configuration
openssl req -new -key "$DOMAIN.key" -out "$DOMAIN.csr" -config "$DOMAIN.cnf"

# Generate a self-signed certificate with the CSR
openssl x509 -req -days 10000 -in "$DOMAIN.csr" -signkey "$DOMAIN.key" -out "$DOMAIN.crt" -extensions v3_req -extfile "$DOMAIN.cnf"
