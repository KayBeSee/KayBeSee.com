---
layout: post
title: Mocking Axios Requests
date: 03-04-2019 22:50:05
categories: [code]
---
One of the challenges to writing good tests for frontend code is getting components in the correct state to test them. A lot of components follow the same pattern of making a network request, displaying some loading state, and then displaying data once it is returned from the server. When writing tests, to avoid making _actual_ network requests, we create mock requests to return certain values _as if_ they actually made the request. At Losant, we use [axios](https://github.com/axios/axios) to make requests, so I wanted to make some notes on how I went about mocking them with Jest to refer back to in the future.

## Setting Up Mock
Throw this up at the top of the file where all your imports are. 


```
jest.mock('axios'); // tell jest to mock axios

import mockAxios from 'axios'; // import the mocked axios file (jest intercepts)
```


## Pending State
We render a loading state as network requests are being made. The code below returns a pending promise that replicates a network request that has been made but no response has been received yet.

```
mockAxios.get.mockImplementation((args) => {
  if (args === 'KevinMulcrone.com') {
    return new Promise(() => { }); // return Promise in pending state (network request made but no response yet)
  }
  if (args === 'status.kevinmulcrone.com') {
    return new Promise(() => { }); // return Promise in pending state (network request made but no response yet)
  }
});
```

## Successful Request Response
To mock an expected successful response from a network request, use the code below

```
mockAxios.get.mockImplementation((args) => {
  if (args === 'KevinMulcrone.com') {
    return Promise.resolve(blogResult);
  }
  if (args === 'status.kevinmulcrone.com') {
    return Promise.resolve(statusBadMessage);
  }
});
```

## Expecting

```
const { container } = render(<MyNetworkFetchingComponent />);
expect(mockAxios.get).toHaveBeenCalledTimes(2);
expect(mockAxios.get).toHaveBeenCalledWith('KevinMulcrone.com');
expect(mockAxios.get).toHaveBeenCalledWith(`status.kevinmulcrone.com`);
```

## Cleaning Up
It's also a good idea to clean up the mocks before running expects so data like network calls aren't being added up.

```
beforeEach(() => {
  mockAxios.get.mockReset();
});

afterEach(() => {
  jest.clearAllTimers();
  cleanup();
});
```




