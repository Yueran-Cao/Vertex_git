

%Recording settings
%These describe which variables to record, we are interested in membrane
%potentials and local field potentials. 
%We save the results of the simulation in this folder, they can be loaded
%at any time after the simulation has finished by loading into memory the
%Results file. Use Results = loadResults(RecordingSettings.saveDir); to do
%this.
RecordingSettings.saveDir = '~/VERTEX_rat_somatosensory_slice/';
RecordingSettings.LFP = true;
[meaX, meaY, meaZ] = meshgrid(500, 200, 0:100:2000);
RecordingSettings.meaXpositions = meaX;
RecordingSettings.meaYpositions = meaY;
RecordingSettings.meaZpositions = meaZ;
RecordingSettings.minDistToElectrodeTip = 20;
RecordingSettings.v_m = 1:1:1000;
RecordingSettings.maxRecTime = 5000;
RecordingSettings.sampleRate = 5000;
RecordingSettings.weights_preN_IDs = 1:1:100;

%Simulation settings:
%Keep max delay steps at 80, 
%Simulation time can be varied, it is in milliseconds, currently running
%for 500 ms.
%We want to run this simulation in parallel, this means that all cpu cores
%will be utilised in the simulations, with the neurons being distributed
%across them, as this simulation is large this is necessary to minimize the
%run time of the simulation. 
SimulationSettings.maxDelaySteps = 80;
SimulationSettings.simulationTime = 600;
SimulationSettings.timeStep = 0.025;
SimulationSettings.parallelSim =true;

%%
%This initialises the network and sets up other variables. 
[params, connections, electrodes] = ...
  initNetwork(TissueParams, NeuronParams, ConnectionParams, ...
              RecordingSettings, SimulationSettings);

%%
runSimulation(params, connections, electrodes);