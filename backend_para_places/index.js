const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
require('dotenv').config(); // Para usar variables de entorno

const app = express();
app.use(cors());
// Manejo explícito de preflight (CORS)
app.options(/.*/, cors()); // 👈 permite todas las solicitudes OPTIONS
app.use(express.json());

// Configuración de conexión MySQL
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

db.connect(err => {
  if (err) {
    console.error('❌ Error al conectar con MySQL:', err);
    return;
  }
  console.log('✅ Conectado a MySQL');
});

// Endpoint de prueba
app.get('/lugares', (req, res) => {
  db.query('SELECT * FROM lugares', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error al obtener lugares');
      return;
    }
    res.json(results);
  });
});

// Rutas de autenticación
const authRoutes = require('./routes/auth');
app.use('/api', authRoutes);

// ✅ Nueva ruta de comentarios
const comentariosRoutes = require('./routes/comentarios');
app.use('/api', comentariosRoutes);

// para los likes
const likesRoutes = require('./routes/likes');
app.use('/api', likesRoutes);


// Puerto dinámico (local o AWS)
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Servidor Express corriendo en puerto ${PORT}`));
