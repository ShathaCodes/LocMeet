const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');
const Location = require('./Location');
const User = require('./User');

const Meeting = sequelize.define('Meeting', {
    date: { type: Sequelize.DATE, allowNull: false },
});


Meeting.hasOne(Location,{onDelete: 'CASCADE',});
Location.belongsTo(Meeting);


module.exports = Meeting;