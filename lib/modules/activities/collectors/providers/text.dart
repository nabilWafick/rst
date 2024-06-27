const params = {
  'skip': 0,
  'take': 24171,
  'where': {
    'AND': [
      {
        'collectionId': {'not': null}
      },
      {'isValidated': true},
      {
        'card': {
          'customer': {
            'collector': {
              '[name][startWith]': "t",
              '[name][mode]': "insensitive"
            }
          }
        }
      }
    ]
  },
  'orderBy': {'id': "asc"}
};

const p = {
  'card': {
    'customer': {
      'collector': {
        "name": {
          "startsWith": "t",
          "mode": "insensitive",
        },
      }
    }
  }
};

const emptyKey = {
  "": {
    "a": "a",
    "test": 1,
    "name": {"startsWith": "t", "mode": "insensitive"},
    "card": {
      "customer": {
        "collector": {
          "name": {"contains": "test"}
        }
      }
    },
    "orderBy": {"id": "asc"},
    "t": "t"
  }
};
