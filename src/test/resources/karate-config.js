function () {
  var uuid = java.util.UUID.randomUUID().toString();
  karate.log("The value of uuid is; ", uuid);
  return {
    suffix: uuid,
    url: 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
  };
}