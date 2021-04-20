const Sequelize = require('sequelize');
const bcrypt = require('bcrypt');
const _ = require('lodash');
const jwt = require('jsonwebtoken');
const Interest = require('../models/Interest');
const Location = require('../models/Location');

const sequelize = require('../config/sequelize');
const { saltRounds } = require('../config/values');

const User = sequelize.define('User', {
    nickname: { type: Sequelize.STRING, allowNull: false,unique: true },
    password: { type: Sequelize.STRING, allowNull: false },
    isAdmin: { type: Sequelize.BOOLEAN, allowNull: false, defaultValue: false }
});

User.belongsToMany(Interest, { through: "user_interest" });

Interest.belongsToMany(User, { through: "user_interest" });

User.hasOne(Location);
Location.belongsTo(User);

User.beforeCreate((user, options) => {
    const hashedPassword = bcrypt.hashSync(user.password, saltRounds);
    user.password = hashedPassword;
});

User.beforeUpdate((user, options) => {
    const hashedPassword = bcrypt.hashSync(user.password, saltRounds);
    user.password = hashedPassword;
});

User.generateAuthToken = async (nickname, clearTextPassword) => {
    const user = await User.findOne({ where: { nickname }, include: [Interest,Location] });

    const jwtPayload = _.pick(user, ['id', 'nickname','Location', 'isAdmin','Interests']);

    if (!user || !bcrypt.compareSync(clearTextPassword, user.password))
        throw new Error();

    const token = jwt.sign(jwtPayload, process.env.JWT_SECRET).toString();

    return token;
};

module.exports = User;