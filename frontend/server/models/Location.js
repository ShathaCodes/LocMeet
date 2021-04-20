const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');

const Location = sequelize.define('Location', {
    lat: { type: Sequelize.DOUBLE, allowNull: false },
    lng: { type: Sequelize.DOUBLE, allowNull: false },
    show: { type: Sequelize.BOOLEAN, allowNull: false, defaultValue: true }
});


module.exports = Location;