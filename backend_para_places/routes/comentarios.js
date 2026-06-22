const express = require('express');
const router = express.Router();
const mysql = require('mysql2');

// Conexión a la base de datos (usa los mismos datos que index.js)
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});


// 📝 GUARDAR COMENTARIO
router.post('/comentarios', (req, res) => {
  const { id_personas, comentario } = req.body;

  // ✅ Valores predeterminados para los campos NOT NULL
  const id_lugares = 'UYUNI'; // puedes reemplazarlo por un id real si lo tienes
  const calificacion = 5; // valor por defecto
  const fecha = new Date().toISOString().split('T')[0]; // formato YYYY-MM-DD
  const id_recomentarios = null;

  if (!id_personas || !comentario) {
    return res.status(400).json({ message: 'Faltan datos requeridos' });
  }

  db.query(
    `INSERT INTO comentarios (id_lugares, comentario, calificacion, fecha, id_personas, id_recomentarios)
     VALUES (?, ?, ?, ?, ?, ?)`,
    [id_lugares, comentario, calificacion, fecha, id_personas, id_recomentarios],
    (err, result) => {
      if (err) {
        console.error('❌ Error al guardar comentario:', err);
        return res.status(500).json({ message: 'Error al guardar comentario' });
      }
      res.status(200).json({ message: 'Comentario guardado correctamente', id: result.insertId });
    }
  );
});


// 📋 OBTENER COMENTARIOS
router.get('/comentarios', (req, res) => {
  db.query('SELECT * FROM comentarios ORDER BY id_comentarios DESC', (err, results) => {
    if (err) {
      console.error('❌ Error al obtener comentarios:', err);
      return res.status(500).json({ message: 'Error al obtener comentarios' });
    }
    res.json(results);
  });
});

module.exports = router;
