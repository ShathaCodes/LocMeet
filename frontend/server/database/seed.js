const { User,Interest,Therapist } = require ('./models')

const seed = async () => {
    
    let users = [
        User.create({
            nickname: 'username1',
            password: 'admin1',
            isAdmin: true,
        }),
        User.create({
            nickname: 'username2',
            password: 'admin2',
            isAdmin: true
        })];
        let interests = [
            Interest.create({
                name: 'sport',
            }),
            Interest.create({
                name: 'baking',
            }),
            Interest.create({
                name: 'crochet',
            }),
            Interest.create({
                name: 'chess',
            }),
            Interest.create({
                name:'music'
            }),
            Interest.create({
                name:'books'
            })
            
        ];
        let therapists = [
            Therapist.create({
                name: 'Mouna Ayedi',
                number: 23121833,
                email:"ayedimouna@yahoo.fr",
                location:'Sfax, Tunis',
                description: 'Graduated in 1998 in Tunisia, Mouna is an expert in treating young adults.'
            }),
            Therapist.create({
                name: 'Ahmed Feki',
                number: 53968411,
                email:"ahmed.feki@gmail.com",
                location:'Paris, France',
                description: 'Ahmed is 45 years old and a famous therapist in Tunis.'
            })
        ];
}

module.exports = seed;