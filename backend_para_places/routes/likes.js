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

// Guardar o actualizar like
router.post('/likes', (req, res) => {
  const { id_persona, id_foto, estado } = req.body;

  db.query(
    `INSERT INTO likes (id_persona, id_foto, estado)
     VALUES (?, ?, ?)
     ON DUPLICATE KEY UPDATE estado = VALUES(estado), fecha = CURRENT_TIMESTAMP`,
    [id_persona, id_foto, estado],
    (err, result) => {
      if (err) {
        console.error('❌ Error al guardar like:', err);
        return res.status(500).json({ message: 'Error al guardar like' });
      }
      res.status(200).json({ message: 'Like actualizado correctamente' });
    }
  );
});

module.exports = router;

