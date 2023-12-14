import 'package:graphql/client.dart';

class GraphQLService {

  static final HttpLink httpLink = HttpLink(
    'http://10.0.2.2:4000/', // Replace with your GraphQL endpoint for local in android avd i've updated 'localhost' with '10.0.2.2'
  );

  static final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
}