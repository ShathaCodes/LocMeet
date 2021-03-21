const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./../models/User');

const Interest = sequelize.define('Interest', {
    name: {type: Sequelize.STRING, allowNull: false}
});


  Interest.associate = (models) => {
    Interest.belongsToMany(User, {
        through : "user_interest",
        // as: "users" ,
       // foreignKey:"interest_id"
    });
  };



module.exports = Interest;