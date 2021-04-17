const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');

const Therapist = sequelize.define('Therapist', {
    name: { type: Sequelize.STRING, allowNull: false },
    number: { type: Sequelize.INTEGER, allowNull: false },
    email: { type: Sequelize.STRING, allowNull: false },
    location: { type: Sequelize.STRING, allowNull: true },
    description: { type: Sequelize.STRING, allowNull: false }
});


module.exports = Therapist;