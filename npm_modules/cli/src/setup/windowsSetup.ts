import path from 'path';
import { checkCommandExists } from '../utils/cliUtils';
import { DevSetupHelper, HOME_DIR } from './DevSetupHelper';
import { ANDROID_WINDOWS_COMMANDLINE_TOOLS } from './versions';

const BAZELISK_URL = 'https://github.com/bazelbuild/bazelisk/releases/download/v1.26.0/bazelisk-windows-amd64.exe';

export async function windowsSetup(): Promise<void> {
  const devSetup = new DevSetupHelper();

  if (!checkCommandExists('java')) {
    await devSetup.runShell('Installing Java Runtime Environment', ['winget install AdoptOpenJDK.OpenJDK.17']);
  }

  if (!checkCommandExists('bazelisk')) {
    const bazeliskPathSuffix = '.valdi/bin/bazelisk.exe';
    const bazeliskTargetPath = path.join(HOME_DIR, bazeliskPathSuffix);
    await devSetup.downloadToPath(BAZELISK_URL, bazeliskTargetPath);
  }
  
  await devSetup.writeEnvVariablesToRcFile([{ name: 'PATH', value: `"$HOME/.valdi/bin:$PATH"` }]);

  await devSetup.setupAndroidSDK(ANDROID_WINDOWS_COMMANDLINE_TOOLS);

  devSetup.onComplete();
}
