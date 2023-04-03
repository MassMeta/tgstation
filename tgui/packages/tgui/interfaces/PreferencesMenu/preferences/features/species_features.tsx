import { FeatureColorInput, Feature, FeatureChoiced, FeatureDropdownInput } from './base';

export const eye_color: Feature<string> = {
  name: 'Eye color',
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: 'Facial hair color',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: 'Facial hair gradient',
  component: FeatureDropdownInput,
};

export const facial_hair_gradient_color: Feature<string> = {
  name: 'Facial hair gradient color',
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: 'Hair color',
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: 'Hair gradient',
  component: FeatureDropdownInput,
};

export const hair_gradient_color: Feature<string> = {
  name: 'Hair gradient color',
  component: FeatureColorInput,
};

export const feature_human_ears: FeatureChoiced = {
  name: 'Ears',
  component: FeatureDropdownInput,
};

export const feature_human_tail: FeatureChoiced = {
  name: 'Tail',
  component: FeatureDropdownInput,
};

export const feature_beef_trauma: Feature<string> = {
  name: 'Beefman Trauma',
  component: FeatureDropdownInput,
};

export const feature_lizard_legs: FeatureChoiced = {
  name: 'Legs',
  component: FeatureDropdownInput,
};

export const feature_lizard_spines: FeatureChoiced = {
  name: 'Spines',
  component: FeatureDropdownInput,
};

export const feature_lizard_tail: FeatureChoiced = {
  name: 'Tail',
  component: FeatureDropdownInput,
};

export const feature_mcolor: Feature<string> = {
  name: 'Mutant color',
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: 'Underwear color',
  component: FeatureColorInput,
};

export const feature_vampire_status: Feature<string> = {
  name: 'Vampire status',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: 'Heterochromatic (Right Eye) color',
  component: FeatureColorInput,
};

export const ipc_screen_toggle: FeatureToggle = {
  name: 'IPC Screen',
  component: CheckboxInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'IPC Screen Selection',
  component: FeatureDropdownInput,
};

export const ipc_screen_color: Feature<string[]> = {
  name: 'IPC Screen Colors',
  component: FeatureTriColorInput,
};

export const ipc_screen_emissive: Feature<boolean[]> = {
  name: 'IPC Screen Emissives',
  component: FeatureTriBoolInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: 'IPC Antenna',
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: 'IPC Antenna Selection',
  component: FeatureDropdownInput,
};

export const ipc_antenna_color: Feature<string[]> = {
  name: 'IPC Antenna Colors',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: 'IPC Antenna Emissives',
  component: FeatureTriBoolInput,
};

export const ipc_chassis_toggle: FeatureToggle = {
  name: 'IPC Chassis',
  component: CheckboxInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: 'IPC Chassis Selection',
  component: FeatureDropdownInput,
};

export const ipc_chassis_color: Feature<string[]> = {
  name: 'IPC Chassis Colors',
  component: FeatureTriColorInput,
};

export const ipc_head_toggle: FeatureToggle = {
  name: 'IPC Head',
  component: CheckboxInput,
};

export const feature_ipc_head: Feature<string> = {
  name: 'IPC Head Selection',
  component: FeatureDropdownInput,
};

export const ipc_head_color: Feature<string[]> = {
  name: 'IPC Head Colors',
  component: FeatureTriColorInput,
};
