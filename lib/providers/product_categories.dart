class ProductCategories {
  final String CategoryId;
  final String CategoryTitle;
  final String CategoryImage;

  ProductCategories(this.CategoryId, this.CategoryTitle, this.CategoryImage);
}

final categoryData = [
  ProductCategories(
      "V",
      "Vehicles",
      // "https://www.sundayobserver.lk/sites/default/files/styles/large/public/news/2017/08/12/tag-Vehicle.jpg?itok=WNN4d2nD"),
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6VKUoxcKm65J4NScLCvPSCwcCFCHjB8RJPkperho9bztYtXe4lPisXU1G0DrSgx39Z0I&usqp=CAU"),
  ProductCategories(
      "E",
      "Appliances",
      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRozAXQdXqKy36gZvUKEdwgnPtiwmo1tXKR7g&usqp=CAU"),
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlgo6Q1FSSKHf__zRWmF7lx51qW7KjxyiH3g&usqp=CAU"),
  ProductCategories(
      "U",
      "Utensils",
      // "https://media.istockphoto.com/vectors/kitchenware-set-kitchen-utensils-and-cutlery-vector-id1248802048"),
      "https://thumbs.dreamstime.com/z/clean-plates-isolated-background-table-group-large-white-objects-background-set-112153309.jpg"),
  ProductCategories(
      "C",
      "Clothes",
      // "https://www.listchallenges.com/f/lists/0db22c14-9ef5-485e-8a3a-3c95fb85a371.jpg"),
      "https://media.istockphoto.com/vectors/colorful-pile-of-dress-vector-id1075970468?b=1&k=20&m=1075970468&s=612x612&w=0&h=yM_HTnxOD9N1Oor8ieXJdpUqbt9VYHlgSdD99oXVZUo="),
];
