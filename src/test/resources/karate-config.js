function fn() {

    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

    var env = karate.env; // get java system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'dev'; // a custom 'intelligent' default
    }
    var config = {
        DBUSERNAME: 'servicepgmicros',
        DBPASSWORD: '',
        DBURL: 'jdbc:postgresql://poolpgmicros.stratiodev.bb.com.mx:20123/dev-sac?ssl=true&sslmode=require',
        DBDRIVER: 'PostgreSQL.jdbc.driver.PostgreSQLDriver',

        randomtelephone: makeid(),
        user: 'mariafd',
        pwd: 'Qwerty123456',

    }
    if (env == 'stage') {
        // over-ride only those that need to be
        config.someUrlBase = 'https://stage-host/v1/auth';
    } else if (env == 'e2e') {
        config.someUrlBase = 'https://e2e-host/v1/auth';
    }

    function makeid() {
        var result = '';
        result += (Math.random() * 1).toString().substring(2, 12);
        return result;
    }


    return config;
}
