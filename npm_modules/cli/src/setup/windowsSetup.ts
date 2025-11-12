import { DevSetupHelper } from './DevSetupHelper';
import { ANDROID_WINDOWS_COMMANDLINE_TOOLS } from './versions';

export async function windowsSetup(): Promise<void> {
  const devSetup = new DevSetupHelper();

  await devSetup.setupAndroidSDK(ANDROID_WINDOWS_COMMANDLINE_TOOLS);

  devSetup.onComplete();
}
