
  net = newff( [0 1; 0 1], [3 1] );
  net.trainParam.epochs = 300;   % Maximum iterations for NN training
  net.trainParam.goal = 1e-3;      % Training goal. (mean squared error)
  net.trainParam.show = 5;          % Show net info after every 5 iterations

% above means that we need a feed forward neural network
% Arg1 = [0 1; 0 1] means we have two inputs. Range of both inputs can be from 0 to 1
% Arg2 = [3 1] means 3 neurons in the hidden layer and 1 output layer

  a = rand(2, 500);     % This is our training data.
  a = a > 0.5;             %Now we have 500 value pairs of 0 or 1 

            %Below loop initiates our Inputs and expected data. For XOR gate
            %Whenever both inputs are same, the output will be 0. else 1
  for i = 1 : 500
    if a(1, i) == a(2, i)
      b(i) = 0;        %This is our expected output to train the NN
    else
      b(i) = 1;       %This is our expected output to train the NN 
    end
  end
  
  [net] = train(net, a, b);        %this will train the network
  
                        %Below we generate some data to test our network. Logic is similar to the first loop above.
  testdata = rand(2,40);
  testdata = testdata > 0.5;

  for i = 1 : 40
    if testdata(1, i) == testdata(2, i)
      expectedresult(i) = 0;
    else
      expectedresult(i) = 1;
    end
  end
  
            % In below loop, we will simulate our network. And compare its results with the expected
            % data from a real XOR gate. As Neural network's output is a double (instead of a digital 0 or 1)
            % so it is possible that some outputs may be like 0.00000121. For this example, we can use thresholding
            % to trim that output to just two levels (0 or 1) and then compare with the expected results.

  for i = 1 : 40
    netResult = sim(net, [testdata(1,i) ; testdata(2,i)]);
    thresholdedResult = netResult > 0.5; 
                %neural network will give us results which are
                %floating points (double). If we apply a threshold then we will convert all results 
                %above 0.5 to 1 and less than 0.5 to 0.
    if (thresholdedResult == expectedresult(i))
      o = "Correct";
    else
      o = "Incorrrect";    
    end
    printf("[%s] Inputs : %i %i. Expected result %i. NN Result %e. Thresholded %i\n", o,testdata(1,i), testdata(2,i), expectedresult(i), netResult, thresholdedResult)
  end