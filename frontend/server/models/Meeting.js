const Sequelize = require('sequelize');
const sequelize = require('../config/sequelize');
const Location = require('./Location');
const User = require('./User');

const Meeting = sequelize.define('Meeting', {
    date: { type: Sequelize.DATE, allowNull: false },
});

User.belongsToMany(Meeting, { as: 'meetings', through: "user_meeting" ,constraints: false});

Meeting.belongsToMany(User, { as: 'guests', through: "user_meeting" ,constraints: false});

Meeting.hasOne(Location,{onDelete: 'CASCADE',});
Location.belongsTo(Meeting);

Meeting.belongsTo( User ,{ as: 'creator' ,constraints: false,foreignKey: 'creatorId',} );
User.hasMany( Meeting ,{as: 'meeting',constraints: false,foreignKey: 'meetingId',} );



module.exports = Meeting;