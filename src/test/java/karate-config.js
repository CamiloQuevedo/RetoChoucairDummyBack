function fn() {
    karate.configure('connectTimeout', 15000);
    karate.configure('readTimeout', 25000);
    karate.configure ('ssl', true);
    return {
            global: {
                       host: 'https://dummy.restapiexample.com',
                       version: '/api/v1'
            }

    };
}