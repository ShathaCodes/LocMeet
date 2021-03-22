const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./../models/User');

const Interest = sequelize.define('Interests', {
    name: {type: Sequelize.STRING, allowNull: false},
   
      }
);







module.exports = Interest;