const User = require('../models/User');
const Interest = require('../models/Interest');
const Location = require('../models/Location');
const { Op } = require("sequelize");

const nearby = async (req, res) => {

    const lat = parseFloat(req.query.lat);
    console.log(req.query);
    const lng = parseFloat(req.query.lng);
    const dist = parseFloat(req.query.distance);
    const t1 = lat-dist;
    const t2 = lat+dist;
    const l1=lng-dist;
    const l2=lng+dist;
	console.log(t1 + "-" + t2);
	console.log(l1 + "-" + l2);
    try {
        const users = await User.findAll(
            {   
                
                attributes: { exclude: [ 'createdAt', 'updatedAt'] },
                include: [{
                    model: Location,
                    where: {
                        lat: { [Op.between]: [t1,t2]  },
                        lng: {  [Op.between]: [l1,l2], },
                        show:true,
                        }, 
                  },
                {
                    model: Interest,
                }]
                });
				
        res.send(users);
        
    } catch (err) {
    }
};

module.exports = nearby;