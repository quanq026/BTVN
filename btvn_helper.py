import os
import subprocess
import re

def get_git_remote_url():
    """Get the origin remote URL and format it for GitHub links."""
    try:
        url = subprocess.check_output(["git", "remote", "get-url", "origin"]).decode().strip()
        if url.endswith('.git'):
            url = url[:-4]
        if url.startswith('git@github.com:'):
            url = url.replace('git@github.com:', 'https://github.com/')
        return url
    except Exception:
        return "https://github.com/quanq026/BTVN"

def get_git_branch():
    """Get the current branch name."""
    try:
        return subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"]).decode().strip()
    except Exception:
        return "main"

GITHUB_REPO_URL = get_git_remote_url()
BRANCH_NAME = get_git_branch()

def get_current_dir_folders():
    """List all directories in the current folder, excluding .git."""
    return [d for d in os.listdir('.') if os.path.isdir(d) and not d.startswith('.')]

def lesson_sort_key(folder_name):
    """Sort folders like L2, L6, SS1 properly."""
    # Find all sequences of digits
    numbers = re.findall(r'\d+', folder_name)
    if numbers:
        # Sort by number first, then prefix
        return (int(numbers[0]), folder_name)
    return (0, folder_name)

def get_files_in_folder(folder_path):
    """List all files in a folder, sorted naturally."""
    if not os.path.exists(folder_path):
        return []
    files = [f for f in os.listdir(folder_path) if os.path.isfile(os.path.join(folder_path, f))]
    # Simple alphanumeric sort
    files.sort(key=lambda x: [int(c) if c.isdigit() else c.lower() for c in re.split('([0-9]+)', x)])
    return files

def get_github_links(folder_name):
    """Generate GitHub links for all files in a folder."""
    files = get_files_in_folder(folder_name)
    links = []
    for file in files:
        # Construct link: https://github.com/user/repo/blob/branch/folder/file
        link = f"{GITHUB_REPO_URL}/blob/{BRANCH_NAME}/{folder_name}/{file}"
        links.append(link)
    return links

def run_git_commands(message):
    """Automate git add, commit, and push."""
    print("\n--- Dang thuc hien Push len GitHub ---")
    try:
        print(f"1. git add .")
        subprocess.run(["git", "add", "."], check=True)
        print(f"2. git commit -m '{message}'")
        subprocess.run(["git", "commit", "-m", message], check=True)
        print(f"3. git push origin {BRANCH_NAME}")
        subprocess.run(["git", "push", "origin", BRANCH_NAME], check=True)
        print("--- Hoan thanh Push thanh cong! ---")
    except subprocess.CalledProcessError as e:
        print(f"\n[!] Loi khi chay git: {e}")
        print("Vui long kiem tra lai quyen truy cap hoac xung dot (conflict).")
        return False
    return True

def main_menu():
    while True:
        folders = get_current_dir_folders()
        # Filter folders that look like lessons (L, SS, Lesson, ss, l, etc.)
        lesson_folders = [f for f in folders if re.search(r'^[LlsS]{1,2}\d+', f) or 'lesson' in f.lower()]
        # Sort descending to get the "latest" at index 0
        lesson_folders.sort(key=lesson_sort_key, reverse=True)

        if not lesson_folders:
            print("\n[!] Khong tim thay folder Lesson nao (VD: L1, SS1, Lesson 1)!")
            print("Cac folder hien co:", folders)
            input("\nNhan Enter de thu lai...")
            continue

        latest_lesson = lesson_folders[0]

        print("\n" + "="*50)
        print("              BTVN HELPER TOOL")
        print("="*50)
        print(f" Repo: {GITHUB_REPO_URL}")
        print(f" Branch: {BRANCH_NAME}")
        print(f" Folder moi nhat: {latest_lesson}")
        print("-" * 50)
        print(" 1. Commit/Push & Lay link folder moi nhat")
        print(" 2. Chon Lesson khac de lay link")
        print(" 3. Thoat")
        print("-" * 50)
        
        choice = input("Nhap lua chon cua ban (1-3): ").strip()

        if choice == '1':
            commit_msg = input(f"Nhap thong diep commit (mac dinh: 'Update {latest_lesson}'): ").strip()
            if not commit_msg:
                commit_msg = f"Update {latest_lesson}"
            
            if run_git_commands(commit_msg):
                links = get_github_links(latest_lesson)
                print(f"\n>>> COPY LINK {latest_lesson} DE GUI GIAO VIEN:")
                print("-" * 50)
                for link in links:
                    print(link)
                print("-" * 50)
                input("\nDone! Nhan Enter de quay lai menu...")
        
        elif choice == '2':
            print("\nDanh sach cac Lesson (tu moi nhat):")
            for idx, folder in enumerate(lesson_folders):
                print(f"{idx + 1}. {folder}")
            
            try:
                lesson_choice = input(f"Chon so (1-{len(lesson_folders)}): ").strip()
                if not lesson_choice: continue
                selected_folder = lesson_folders[int(lesson_choice) - 1]
                links = get_github_links(selected_folder)
                print(f"\n>>> LINK CAC FILE TRONG {selected_folder}:")
                print("-" * 50)
                for link in links:
                    print(link)
                print("-" * 50)
                input("\nNhan Enter de quay lai menu...")
            except (ValueError, IndexError):
                print("[!] Lựa chọn không hợp lệ.")

        elif choice == '3':
            print("Tam biet!")
            break
        else:
            print("[!] Lua chon khong hop le.")

if __name__ == "__main__":
    main_menu()

